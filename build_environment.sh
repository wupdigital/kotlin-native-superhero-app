#!/bin/sh

preprocessFile="./marvel.pch"

echo "Creating header file ${preprocessFile}"

echo "//------------------------------------------" > $preprocessFile
echo "// Auto generated file. Don't edit manually." >> $preprocessFile
echo "// See build_environment script for details." >> $preprocessFile
echo "// Created $buildDate" >> $preprocessFile
echo "//------------------------------------------" >> $preprocessFile
echo "" >> $preprocessFile
echo "#define MARVEL_PUBLIC_API_KEY         $MARVEL_PUBLIC_API_KEY" >> $preprocessFile
echo "#define MARVEL_PRIVATE_API_KEY        $MARVEL_PRIVATE_API_KEY" >> $preprocessFile

echo 'Done.'
