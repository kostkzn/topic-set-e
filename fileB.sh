#!/bin/bash

function helo1() {
    echo "Wait: $1"
    exit 1

}

function helo() {
    helo1 "there exists an error"
    echo "unreachable echo"
}
