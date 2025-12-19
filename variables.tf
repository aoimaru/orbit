variable "project" {
    description = "プロジェクト名"
    type = string
}

variable "environment" {
    description = "環境"
    type = string 
    validation {
        condition = contains(["prod", "stg", "dev"], var.environment)
        error_message = "You have to use 'dev', 'stg', 'prod' only"
    }
}

variable "ver" {
    description = "バージョン"
    type = string
}

