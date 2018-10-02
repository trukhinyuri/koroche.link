

resource "aws_key_pair" "deployer_public_key" {
  provider = "aws.aws_provider_eu_west_Ireland"
  key_name   = "deployer-key"
  public_key = "${var.public_ssh_key}"
}

resource "aws_ecr_repository" "container_storage_eu_west_Ireland" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name = "container_storage_eu_west_ireland"
}

resource "aws_ecr_repository" "container_storage_us_west_NCalifornia" {
  provider = "aws.aws_provider_us_west_NCalifornia"
  name = "container_storage_us_west_ncalifornia"
}

resource "aws_ecr_repository" "container_storage_eu_central_Frankfurt" {
  provider = "aws.aws_provider_eu_central_Frankfurt"
  name = "container_storage_eu_central_frankfurt"
}



//resource "aws_instance" "container_builder" {
//  provider = "aws.aws_provider_eu_west_Ireland"
//  ami = "ami-00035f41c82244dab"
//  instance_type = "t2.nano"
//  private_ip = "10.0.0.12"
//  key_name = "${aws_key_pair.deployer_public_key.key_name}"
//  subnet_id = "${aws_subnet.subnet_Ireland.id}"
//}





//resource "aws_s3_bucket" "storage_bucket" {
//  bucket = "${var.shortener_domain}"
//  acl    = "public-read"
//  policy = "${data.template_file.s3_public_policy.rendered}"
//
//  website {
//    index_document = "index.html"
//  }
//
//  tags {
//    Name        = "${var.shortener_domain}"
//    Environment = "${var.env}"
//  }
//}
//
//resource "aws_s3_bucket_object" "index" {
//  bucket = "${var.shortener_domain}"
//  key = "index.html"
//  source = "frontend/index.html"
//  content_type = "text/html"
//  etag = "${md5(file("frontend/index.html"))}"
//  depends_on = ["aws_s3_bucket.storage_bucket"]
//}
//
//output "url" {
//  value = "${aws_s3_bucket.storage_bucket.bucket}.s3-website-${var.aws_region_main}.amazonaws.com"
//}

//_________________________________________________________________________________

//resource "aws_route53_zone" "main" {
//  name = "${var.shortener_domain}"
//}
//
//resource "aws_route53_record" "root_domain" {
//  zone_id = "${aws_route53_zone.main.zone_id}"
//  name = "${var.shortener_domain}"
//  type = "A"
//
//  alias {
//    name = "${aws_s3_bucket.storage_bucket.bucket}.s3-website-${var.aws_region_main}.amazonaws.com"
//    zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
//    evaluate_target_health = false
//  }
//}
//
//resource "aws_cloudfront_distribution" "cdn" {
//  origin {
//    origin_id   = "${var.shortener_domain}"
//    domain_name = "${aws_s3_bucket.storage_bucket.bucket}.s3-website-${var.aws_region_main}.amazonaws.com"
//  }
//
//  # If using route53 aliases for DNS we need to declare it here too, otherwise we'll get 403s.
//  aliases = ["${var.shortener_domain}"]
//
//  enabled             = true
//  default_root_object = "index.html"
//
//  default_cache_behavior {
//    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
//    cached_methods   = ["GET", "HEAD"]
//    target_origin_id = "${var.shortener_domain}"
//
//    forwarded_values {
//      query_string = true
//      cookies {
//        forward = "none"
//      }
//    }
//
//    viewer_protocol_policy = "allow-all"
//    min_ttl                = 0
//    default_ttl            = 3600
//    max_ttl                = 86400
//  }
//
//  # The cheapest priceclass
//  price_class = "PriceClass_100"
//
//  # This is required to be specified even if it's not used.
//  restrictions {
//    geo_restriction {
//      restriction_type = "none"
//      locations        = []
//    }
//  }
//
//  viewer_certificate {
//    cloudfront_default_certificate = true
//  }
//}
//
////output "s3_website_endpoint" {
////  value = "${aws_s3_bucket.site.website_endpoint}"
////}
//
//output "route53_domain" {
//  value = "${aws_route53_record.root_domain.fqdn}"
//}
//
//output "cdn_domain" {
//  value = "${aws_cloudfront_distribution.cdn.domain_name}"
//}