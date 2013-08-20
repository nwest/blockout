Sequel.migration do
  change do
    create_table(:streamers) do
      primary_key :id
      String :name, default: ""
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
