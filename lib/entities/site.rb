module Place
    class Place < Dry :: Struct
        include Dry :: Types.module
        
        attribute :site,  Strict::String
        
    end
end