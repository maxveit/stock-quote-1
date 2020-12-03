#!/bin/bash

maven_goals="install"

image_name="stock-quote"
image_tag="latest"
image_namespace="stocktrader"

deployment_create="true"
deplyoment_namespace="stocktrader"

kubectl_apply="services.yaml"
