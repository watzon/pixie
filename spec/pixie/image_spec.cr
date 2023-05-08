require "../spec_helper"

Spectator.describe Pixie::Image do
  describe ".new" do
    it "creates a new image with the given dimensions and background" do
      image = Pixie::Image.new(200, 100, Pixie::Pixel::RED)
      expect(image.width).to eq 200
      expect(image.height).to eq 100
      expect(image.background_color).to eq Pixie::Pixel::RED
    end

    it "raises an error if the image cannot be read" do
      expect {
        Pixie::Image.new("spec/fixtures/does_not_exist.jpg")
      }.to raise_error Pixie::Image::ReadError
    end

    it "raises an error if the input is not an image" do
      expect {
        Pixie::Image.new("spec/fixtures/not_an_image.rb")
      }.to raise_error Pixie::Image::ReadError
    end
  end

  describe ".import_pixels" do
    let(:dimensions) { [325, 200] }
    let(:depth)      { 16 }
    let(:map)        { "gray" }
    let(:pixels)     { Array(Int32).new(dimensions[0] * dimensions[1]) { |i| i } }

    it "can import pixels with the default format" do
      image = Pixie::Image.import_pixels(pixels, dimensions[0], dimensions[1], depth, map)
      expect(image.width).to eq dimensions[0]
      expect(image.height).to eq dimensions[1]
    end
  end

  describe "#read" do
  it "reads an image from a file path" do
    image = Pixie::Image.new
    image.read("spec/fixtures/default.jpg")
    expect(image.width).to eq 200
    expect(image.height).to eq 276
  end

  it "reads an image from a file" do
    image = Pixie::Image.new
    file = File.open("spec/fixtures/default.jpg")
    image.read(file)
    expect(image.width).to eq 200
    expect(image.height).to eq 276
    file.close
  end

  it "reads an image from a buffer" do
    image = Pixie::Image.new
    file = File.open("spec/fixtures/default.jpg")
    buffer = file.gets_to_end.to_slice
    image.read(buffer)
    expect(image.width).to eq 200
    expect(image.height).to eq 276
  end

  it "returns false if the image cannot be read" do
    image = Pixie::Image.new
    expect(image.read("spec/fixtures/does_not_exist.jpg")).to be false
  end

  it "returns false if the input is not an image" do
    image = Pixie::Image.new
    expect(image.read("spec/fixtures/not_an_image.rb")).to be false
  end
end

  describe "#[]" do
    it "gets image details using formatting characters" do
      image = Pixie::Image.new("spec/fixtures/default.jpg")

      wh = image["%wx%h"]
      expect(wh).to eq "200x276"

      f = image["%f"]
      expect(f).to eq "default.jpg"

      e = image["%e"]
      expect(e).to eq "jpg"

      d = image["%d"]
      expect(d).to eq "spec/fixtures"
    end

    it "gets a specific image in a set" do
      image = Pixie::Image.new
      image.read("spec/fixtures/default.jpg")
      image.read("spec/fixtures/engine.png")

      expect(image[0].width).to eq 200
      expect(image[0].height).to eq 276

      expect(image[1].width).to eq 300
      expect(image[1].height).to eq 225
    end
  end

  describe "#==" do
    it "returns true if the images are the same" do
      image1 = Pixie::Image.new("spec/fixtures/default.jpg")
      image2 = Pixie::Image.new("spec/fixtures/default.jpg")
      expect(image1).to eq image2
    end

    it "returns false if the images are different" do
      image1 = Pixie::Image.new("spec/fixtures/default.jpg")
      image2 = Pixie::Image.new("spec/fixtures/engine.png")
      expect(image1).not_to eq image2
    end
  end

  describe "#layers" do
    it "returns the layers in an image as an array of individual images" do
      image = Pixie::Image.new("spec/fixtures/animation.gif")
      layers = image.layers
      expect(layers.size).to eq 19
    end
  end
end
