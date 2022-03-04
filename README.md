# Casino-I18N

[![CI](https://github.com/badetitou/Casino-I18N/actions/workflows/test.yml/badge.svg)](https://github.com/badetitou/Casino-I18N/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/badetitou/Casino-I18N/badge.svg?branch=master)](https://coveralls.io/github/badetitou/Casino-I18N?branch=master)

This project aims to ease the migration of I18N properties files to one I18N json files.

The input looks like:

```properties
################################################################################
#          Some comment
#
################################################################################

# other comment

key=aValue
anotherKey=AnotherValue
```

The ouput is then

```json
{
  "property fileName": {
    "key": "aValue",
    "anotherKey": "AnotherValue"
  }
}
```

## Installation

To install Casino-I18N, download a [Moose9 image](https://modularmoose.org/moose-wiki/Beginners/InstallMoose).
Then, in a playground (<kdb>Ctrl + O</kdb>, <kdb>Ctrl + P</kdb>), perform: 

```st
Metacello new
  githubUser: 'badetitou' project: 'Casino-I18N' commitish: 'master' path: 'src';
  baseline: 'Casino18N';
  onConflict: [ :ex | ex useIncoming ];
  onUpgrade: [ :ex | ex useIncoming ];
  onDowngrade: [ :ex | ex useLoaded ];
  load
```

## Usage

### Extraction

The main class for the extraction is: `CS18NPropertiesImporter`.
It extracts into a model a properties file.

example:

```st
| i18nModel importer |
i18nModel := CS18NModel new.

importer := CS18NPropertiesImporter new.
importer model: i18nModel.

importer importFile: 'D:\path\to\file\myfile_en.properties' asFileReference.
importer model
```

It is possible to extract the I18N of all files under a specific folder:

```st
"Import all fr entries from the <myProject> folder" 
('D:\MyApp' asFileReference allChildrenMatching: '*_fr.properties') do: [ :fileRef | 
  "Log with TinyLogger"
  self record: fileRef absolutePath basename.
  "Import"
  importer importFile: fileRef.
].
```

### Generation

The main class for the json generation is: `CS18NPropertiesExporter`.
Considering a I18N model, a target language (as string), and a write stream to the file, it generates the target JSON.

example:

```st
'D:/myApp-fr.json' asFileReference writeStreamDo: [ :stream |
  CS18NPropertiesExporter new
    model: importer model;
    stream: stream;
    language: ((importer model allWithType: CS18NLanguage) detect: [ :lang | lang shortName = 'fr' ]);
    export
].

```

## Casino developers (export to Angular)

This project comes with an integration to the Casino project to automatize the migration of I18N attributes.

### Installation

To install the project with its integration to Casino.

```st
Metacello new
  githubUser: 'badetitou' project: 'Casino-I18N' commitish: 'master' path: 'src';
  baseline: 'Casino18N';
  onConflict: [ :ex | ex useIncoming ];
  onUpgrade: [ :ex | ex useIncoming ];
  onDowngrade: [ :ex | ex useLoaded ];
  load: 'casino'
```

### Usage

Once a I18N model is extracted, one can convert a Casino model with the `CSNE18NModelTransformation` util.

```st
"Add information to Casino model"
CSNE18NModelTransformation new
  csnModel: gwtModel;
  i18nModel: i18nModel;
  bind.
```

Then, it is possible to use the `CSE18NExporterAngularAttribute` instead of the `CSNExporterAngularAttribute` to export the i18n key inside the Angular HTML code.

> Some adaptation of the code might be required.

For the `CSNModelExporterAngularBLIdentity` of [Berger-Levrault](https://www.berger-levrault.com):

```st
"Create an exporter"
exporter := CSNModelExporterAngularBLIdentity new.
exporter identityConfiguration: configXML.
"Here set another attribute exporter"
exporter attributeExporter: CSE18NExporterAngularAttribute new.
"Use the material.angular.io as target library"
exporter exporterAngularConfiguration: CSNExporterAngularMaterialConfiguration new.
exporter model: gwtModel.
```
