variable "argocd_name" {
  description = "Name of the ArgoCD Helm release"
  type        = string
  default     = "argo-cd"
}

variable "argocd_repository" {
  description = "Helm chart repository for ArgoCD"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argocd_chart" {
  description = "Helm chart name for ArgoCD"
  type        = string
  default     = "argo-cd"
}

variable "argocd_version" {
  description = "Helm chart version for ArgoCD"
  type        = string
  default     = "9.4.4"
}

variable "argocd_namespace" {
  description = "Namespace to install ArgoCD"
  type        = string
  default     = "argocd"
}

variable "kube_config" {
  type = object({
    host                   = string
    username               = string
    password               = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
  })
  description = "Kubeconfig info to connect to AKS cluster"
}
