aws_region           = "eu-west-2"
name                 = "myapp"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
availability_zones   = ["eu-west-2a", "eu-west-2b"]

allowed_ingress_cidr = ["0.0.0.0/0"]

route53_zone_name    = "example.com"
dns_record_name      = "app.example.com"

container_image      = "nginx:latest"
container_port       = 80
desired_count        = 2
cpu                  = 256
memory               = 512
health_check_path    = "/"

tags = {
  Environment = "dev"
  Project     = "myapp"
  ManagedBy   = "Terraform"
}