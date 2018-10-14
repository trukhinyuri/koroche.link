data "template_file" "s3_public_policy" {
  template = "${file("policies/s3-public.json")}"

  vars {
    bucket_name = "${var.domain}"
  }
}
