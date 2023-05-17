data "external" "secret" {
  program = ["python3", "${path.module}/scripts/generator.py"]
}
