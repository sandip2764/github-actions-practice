
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-s3-bucket-124072004345"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}