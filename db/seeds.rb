[
  "Not Specified",
  "Spouse",
  "Immediate Family",
  "Extended Family",
  "Friend",
  "BFF",
  "Other Acquaintance"
].each do |name|
  Relation.where(name: name).first_or_create
end
