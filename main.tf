resource "aws_s3_bucket" "storage_bucket" {
  bucket = "${var.shortener_domain}"
  acl    = "public-read"
  policy = "${data.template_file.s3_public_policy.rendered}"

  website {
    index_document = "index.html"
  }

  tags {
    Name        = "${var.shortener_domain}"
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = "${var.shortener_domain}"
  key = "index.html"
  source = "frontend/index.html"
  content_type = "text/html"
  etag = "${md5(file("frontend/index.html"))}"
}

output "url" {
  value = "${aws_s3_bucket.storage_bucket.bucket}.s3-website-${var.aws_region_main}.amazonaws.com"
}

resource "aws_route53_zone" "main" {
  name = "${var.shortener_domain}"
}

resource "aws_route53_record" "root_domain" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name = "${var.shortener_domain}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.cdn.domain_name}"
    zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    origin_id   = "${var.shortener_domain}"
    domain_name = "${var.shortener_domain}.s3.amazonaws.com"
  }

  # If using route53 aliases for DNS we need to declare it here too, otherwise we'll get 403s.
  aliases = ["${var.shortener_domain}"]

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.shortener_domain}"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # The cheapest priceclass
  price_class = "PriceClass_100"

  # This is required to be specified even if it's not used.
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

//output "s3_website_endpoint" {
//  value = "${aws_s3_bucket.site.website_endpoint}"
//}

output "route53_domain" {
  value = "${aws_route53_record.root_domain.fqdn}"
}

output "cdn_domain" {
  value = "${aws_cloudfront_distribution.cdn.domain_name}"
}