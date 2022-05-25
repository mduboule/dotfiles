#!/bin/bash
sed -i '' 's/go": "stmux/go": "stmux -a o/g' package.json
