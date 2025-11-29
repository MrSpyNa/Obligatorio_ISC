#!/bin/bash

find . -type f -name "main.tf" -exec dirname {} \; | while read dir
do
  echo "📘 Generando documentación en $dir"
  terraform-docs markdown "$dir" > "$dir/README.md"
done
