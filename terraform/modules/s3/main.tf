resource "aws_s3_bucket" "bucket1" {
    bucket = var.bucket_name1
    force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.bucket1.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket" "bucket2" {
    bucket = var.bucket_name2
    force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning2"{
    bucket = aws_s3_bucket.bucket2.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket" "bucket3" {
    bucket = var.bucket_name3
    force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning3"{
    bucket = aws_s3_bucket.bucket3.id
    versioning_configuration {
        status = "Enabled"
    }
}
