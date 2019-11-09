package main

deny[msg] {
    bucket_changes := input.resource_changes[_] # Some changes exist
    bucket_changes.type == "google_storage_bucket" # And they have this type
    count(bucket_changes.change.after.name) > 63
    msg = "Storage bucket names must be between 3 and 63 characters"
}

# deny[msg] { 
#     bucket_changes := input.resource_changes[_] # Some changes exist
#     bucket_changes.type == "google_storage_bucket" # And they have this type
#     not bucket_changes.change.after.labels.env # And does not have a env label
#     msg = "Storage buckets must have an env label"
# }

deny[msg] { 
    bucket_changes := input.resource_changes[_] # Some changes exist
    bucket_changes.type == "google_storage_bucket" # And they have this type
    resources := re_match("dev|qa|prod", bucket_changes.change.after.labels.env) # And matches regex
    msg = "Storage buckets must env label with one of the following values: dev, qa, prod"
    #msg := sprintf("Storage buckets must env label with one of the following values: dev, qa, prod: %v", [resources])
}

# is_valid_environment(environment) {
#     re_match("dev|qa|prod", environment)
# }