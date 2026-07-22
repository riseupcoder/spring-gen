# Spring-Gen

A lightweight Spring Boot domain scaffolding generator that automates repetitive backend boilerplate creation.

Spring-Gen helps developers quickly create common domain layers such as entities, repositories, services, controllers, DTOs, and mappers without manually creating the same files repeatedly.

## Features

- Zero dependencies
- Built with standard Linux tools
- Prototype-based file generation
- Automatically detects the Spring Boot base package
- Generates correct Java package declarations
- Safe file generation without overwriting existing files
- Easy to customize and extend

## Requirements

- Linux
- Bash
- Spring Boot project

## Installation

Clone the repository:

```bash
git clone https://github.com/riseupcoder/spring-gen.git
```

Copy the generator files into your Spring Boot project root:

```bash
cp -r spring-gen/* /path/to/your/springboot-project/
```

Navigate to your project:

```bash
cd /path/to/your/springboot-project
```

Make the script executable:

```bash
chmod +x spring-generator.sh
```

## Usage

Generate a new domain:

```bash
./spring-generator.sh Event
```

Example output:

```text
event/

├── Event.java
├── EventRepository.java
├── EventService.java
├── EventServiceImpl.java
├── EventController.java
│
├── dto/
│   ├── request/
│   │   ├── CreateEventRequest.java
│   │   └── UpdateEventRequest.java
│   │
│   └── response/
│       ├── EventResponse.java
│       └── EventPageResponse.java
│
├── mapper/
│   └── EventMapper.java
│
└── enums/
```

## Extending

Spring-Gen uses simple Java prototypes.

To add a new generated file:

1. Create a new prototype inside the `prototypes` directory.
2. Add the generation rule to the script.

Example:

```bash
"Specification.java|${domain_name}Specification.java"
```

No generator logic changes are required.

## Design Goals

Spring-Gen intentionally stays small and transparent:

- No external dependencies
- No compiled binaries
- Easy to inspect
- Easy to modify
- Easy to move between machines

The generated code remains fully under the developer's control.

## License

MIT License
