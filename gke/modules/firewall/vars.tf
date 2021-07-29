variable project {}
variable name   {}
variable network {}
variable protocol {}
variable ports { type = "list" default = [] }
variable range { type = "list" default = [] }
variable source_tags { type = "list" default = [] }
variable target_tags { type = "list" default = [] }
variable priority { default = "1000" }
variable direction { default = "INGRESS" }
