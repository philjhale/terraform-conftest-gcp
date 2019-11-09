package main

deny[msg] {
    bucket_changes := input.resource_changes[_] # Some changes exist
    bucket_changes.type == "google_storage_bucket" # And they have this type
    count(bucket_changes.change.after.name) > 63
    msg = sprintf("%v - Storage bucket names must be between 3 and 63 characters", [bucket_changes.change.after.name])
}

deny[msg] { 
    bucket_changes := input.resource_changes[_] # Some changes exist
    bucket_changes.type == "google_storage_bucket" # And they have this type
    not bucket_changes.change.after.labels.env # And does not have a env label
    msg := sprintf("%v - Storage buckets must have an env label with one of the following values: dev, qa, prod", [bucket_changes.change.after.name])
}

deny[msg] { 
    bucket_changes := input.resource_changes[_] # Some changes exist
    bucket_changes.type == "google_storage_bucket" # And they have this type
    not re_match("^dev$|^qa$|^prod$", bucket_changes.change.after.labels.env) # And does not match
    msg := sprintf("%v - Storage buckets env label must be one of the following values: dev, qa, prod", [bucket_changes.change.after.name])
}

# is_valid_environment(environment) {
#     re_match("dev|qa|prod", environment)
# }