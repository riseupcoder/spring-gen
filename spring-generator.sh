#!/usr/bin/env bash

set -euo pipefail

DIRECTORIES=(
    "dto/request"
    "dto/response"
    "mapper"
    "enums"
)

domain_name=""
base_package=""
package_name=""
package_path=""

created_count=0
skipped_count=0

load_project_package() {
    local application_file
    local package_folder

    application_file=$(find src/main/java \
        -name "*Application.java" \
        -print -quit)

    if [[ -z "$application_file" ]]; then
        echo "Spring Boot Application class not found"
        exit 1
    fi

    base_package=$(grep '^package ' "$application_file")
    base_package="${base_package#package }"
    base_package="${base_package%;}"

    package_folder="${domain_name,,}"

    package_name="$base_package.$package_folder"
    package_path="src/main/java/${package_name//./\/}"
}

create_directories() {
    mkdir -p "$package_path"

    for directory in "${DIRECTORIES[@]}"
    do
        mkdir -p "$package_path/$directory"
    done
}

create_file() {
    local prototype="$1"
    local destination="$2"

    local output="$package_path/$destination"

    if [[ -e "$output" ]]; then
        echo "skipped: $destination"
        skipped_count=$((skipped_count + 1))
        return
    fi

    local filename
    local class_name
    local entity_name
    local java_package
    local directory

    filename=$(basename "$destination")
    class_name="${filename%.java}"
    entity_name="${class_name%Repository}"

    java_package="$package_name"

    directory=$(dirname "$destination")

    if [[ "$directory" != "." ]]; then
        java_package="$java_package.${directory//\//.}"
    fi

    cp "prototypes/$prototype" "$output"

    sed -i \
        -e "s|{{PACKAGE}}|$java_package|g" \
        -e "s|{{CLASS_NAME}}|$class_name|g" \
        -e "s|{{ENTITY}}|$entity_name|g" \
        "$output"

    echo "created: $destination"

    created_count=$((created_count + 1))
}

main() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: ./spring-generator.sh DomainName"
        exit 1
    fi

    domain_name="$1"

    local generations=(
        "Entity.java|${domain_name}.java"
        "Controller.java|${domain_name}Controller.java"
        "Service.java|${domain_name}Service.java"
        "ServiceImpl.java|${domain_name}ServiceImpl.java"
        "Record.java|dto/request/Create${domain_name}Request.java"
        "Record.java|dto/request/Update${domain_name}Request.java"
        "Record.java|dto/response/${domain_name}Response.java"
        "Record.java|dto/response/${domain_name}PageResponse.java"
        "Mapper.java|mapper/${domain_name}Mapper.java"
        "Repository.java|${domain_name}Repository.java"
    )

    load_project_package
    create_directories

    for item in "${generations[@]}"
    do
        IFS="|" read -r prototype destination <<< "$item"
        create_file "$prototype" "$destination"
    done

    echo
    echo "=============================="
    echo "Domain generation completed"
    echo "=============================="
    echo "Created : $created_count"
    echo "Skipped : $skipped_count"
}

main "$@"
