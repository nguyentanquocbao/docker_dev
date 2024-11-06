# Data Engineering Docker Setup

This repository provides a complete Docker-based environment for Python development, Spark (master and worker), Hadoop servers (Resource Manager, NameNode, DataNode), and PostgreSQL database.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
- [Docker Setup](#docker-setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction
This project simplifies the setup of a data engineering environment using Docker. It includes a development environment for Python, a Spark cluster, Hadoop components, and a PostgreSQL database, making it easy to start developing and testing your data pipelines.

## Features
- **Python Development**: Development environment with necessary libraries and tools.
- **Spark Cluster**: Spark master and worker nodes.
- **Hadoop Servers**: Resource Manager, NameNode, and DataNode.
- **PostgreSQL Database**: A fully functional PostgreSQL instance
# Setting Up the Docker Development Environment

This guide will walk you through cloning the `docker_dev` repository and running Docker Compose with your YAML configuration file.

## Prerequisites

- Make sure Docker and Docker Compose are installed on your system. You can follow the official Docker installation guide [here](https://docs.docker.com/get-docker/).
- Check that both `git` and Docker Compose are working by running:
  ```bash
  git --version
  docker --version
  docker compose version
clone my git 
```Shell
git clone https://github.com/nguyentanquocbao/docker_dev.git
cd docker_dev
docker compose up -d
```
Enjoy coding! 
