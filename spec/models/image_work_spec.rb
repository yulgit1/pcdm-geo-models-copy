# Generated via
#  `rails generate curation_concerns:work ImageWork`
require 'rails_helper'
require 'spec_helper'

describe ImageWork do
  let(:user) { FactoryGirl.find_or_create(:jill) }
  let(:image_file1) { FileSet.new(geo_file_format: 'TIFF') }
  let(:ext_metadata_file1 ) { FileSet.new(geo_file_format: 'ISO19139') }
  let(:ext_metadata_file2 ) { FileSet.new(geo_file_format: 'ISO19139') }
  let(:raster1 ) { RasterWork.new }
  let(:raster2 ) { RasterWork.new }

  it 'updates the title' do
    subject.attributes = { title: ['An image work'] }
    expect(subject.title).to eq(['An image work'])
  end

  describe 'metadata' do
    it 'has descriptive metadata' do
      expect(subject).to respond_to(:title)
    end
  end

  describe 'with acceptable inputs' do
    subject { described_class.new } 
    it 'add image,metadata,raster to file' do
      subject.members << image_file1
      subject.members << ext_metadata_file1
      subject.members << ext_metadata_file2
      subject.members << raster1
      subject.members << raster2
      expect(subject.image_file).to eq image_file1
      expect(subject.metadata_files).to eq [ext_metadata_file1,ext_metadata_file2]
      expect(subject.raster_works).to eq [raster1,raster2]
    end
  end

  context 'georeferenced to a raster' do
    subject { FactoryGirl.create(:image_work_with_raster_works, title: ['Test title 4'], bounding_box: '17.881242 -179.14734 71.390482 179.778465') }

    it 'aggregates by raster resources' do
      expect(subject.raster_works.size).to eq 2
      expect(subject.raster_works.first).to be_kind_of RasterWork
    end
  end

  describe 'extract_metadata' do
    subject { FactoryGirl.create(:image_work_with_one_metadata_file) }

    it 'has an extraction method' do
      expect(subject).to respond_to(:extract_metadata)
    end

    it 'can perform extraction for ISO 19139' do
      doc = Nokogiri::XML(read_test_data_fixture('McKay/S_566_1914_clip_iso.xml'))
      externalMetadataFile = subject.metadata_files.first
      expect(externalMetadataFile.geo_file_format.downcase).to eq('iso19139')
      allow(externalMetadataFile).to receive(:metadata_xml) { doc }
      subject.extract_metadata
      expect(subject.title).to eq(['S_566_1914_clip.tif'])
    end
  end
end