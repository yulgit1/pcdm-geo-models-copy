module GeoConcerns
  class BasicGeoMetadataOptional < ActiveTriples::Schema
    #
    # The following properties are inherited from Curation Concerns' metadata
    #
    # @see https://github.com/projecthydra/curation_concerns/blob/v1.6.0/app/models/concerns/curation_concerns/basic_metadata.rb
    # Optional:
    #   :contributor
    #   :creator
    #   :date_created (DC.created)
    #   :description
    #   :identifier
    #   :language
    #   :part_of
    #   :publisher
    #   :resource_type (DC.type)
    #   :rights (license)
    #   :rights
    #   :source
    #   :subject
    #   :tag (DC11.relation)
    #

    # Defines the placenames related to the layer
    # @example
    #   image.spatial = [ 'France', 'Spain' ]
    property :spatial, predicate: ::RDF::Vocab::DC.spatial

    # Defines the temporal coverage of the layer
    # @example
    #   vector.temporal = [ '1998-2006', 'circa 2000' ]
    property :temporal, predicate: ::RDF::Vocab::DC.temporal

    # Defines the issued date for the layer, using XML Schema dateTime format
    #   (YYYY-MM-DDThh:mm:ssZ).
    # @example
    #   vector.issued = '2001-01-01T00:00:00Z'
    property :issued, predicate: ::RDF::Vocab::DC.issued, multiple: false
  end
end
