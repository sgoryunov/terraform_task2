variable "my_key_name" {
    type = string
    default = "sgoryunov"
    description = "Key pair name"
}
variable "sg_name" {
    type = string
    default = "epam-by-ru"
    description = "Russian security group"
}
variable "owner_tag" {
    type = string
    default = "semen_goryunov@epam.com"
    description = "Owner tag"
}