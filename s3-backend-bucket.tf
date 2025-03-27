resource "aws_s3_bucket" "remote-backend-tfstate" {
    bucket = "profisee-tfstate"
    tags = {
        Name = "profisee-tfstate"
        Environment = "profisee"
    }
}

resource "aws_s3_bucket_versioning" "remote-backend-version" {
    bucket = aws_s3_bucket.remote-backend-tfstate.id
    versioning_configuration {
        status = "Enabled"
    }
}
