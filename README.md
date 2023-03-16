# Casino-I18N

[![CI](https://github.com/badetitou/Casino-I18N/actions/workflows/test.yml/badge.svg)](https://github.com/badetitou/Casino-I18N/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/badetitou/Casino-I18N/badge.svg?branch=master)](https://coveralls.io/github/badetitou/Casino-I18N?branch=master)

This project aims to facilitate the migration of I18N properties files to an I18N json file.

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

The main extraction class is `CS18NPropertiesImporter`.
It extracts a properties file into a model.\
Since the convention used to produce these files may differ from project to project, there are different strategies for extracting:
- a language from a file:
  - `CS18NFileNameLanguageStrategy` uses the file's name,
  - `CS18NFileNameSuffixLanguageStrategy` uses the suffix of the file's name after the last user-defined separator;
- namespaces from a file:
  - `CS18NFileNameNamespaceStrategy` uses the file's name,
  - `CS18NFileNamePrefixNamespaceStrategy` uses the prefix of the file's name up to the last user-defined separator,
  - `CS18NFilePathNamespaceStrategy` uses indexed elements of the file's path for nested namespaces,
  - `CS18NRootNamespaceStrategy` answers the model's root namespace;
- an entry from a key:
  - `CS18NLiteralEntryStrategy` uses the key as-is,
  - `CS18NNestedEntryStrategy` considers the key to be in qualified notation for an entry nested in namespaces,
  - `CS18NSmartEntryStrategy` behaves like the 'nested' strategy until it finds a conflict between an entry's key and a namespace, then it tries to avoid it by approaching the behavior of the 'literal' strategy.

Also:
- a `Static` strategy for languages and namespaces, which always returns the same user-defined entity,
- a `Pluggable` strategy for each, which takes a user-defined block for an easy custom implementation.

example:

```st
| importer |
importer := CS18NPropertiesImporter new
  model: CS18NModel new;
  languageStrategy: (CS18NFileNameSuffixLanguageStrategy new separator: $_);
  namespaceStrategy: (CS18NStaticNamespaceStrategy new namespace: 'root');
  entryStrategy: CS18NLiteralEntryStrategy new.

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

The main class for generating the JSON file  is `CS18NPropertiesExporter`.
Given an I18N model, a target language (as string), and a write stream to the file, it generates the target JSON.

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

This project includes an integration with the Casino project to automate the migration of I18N attributes.

### Installation

To install the project with its integration with Casino:

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

Once an I18N model has been extracted, a Casino model can be converted using the `CSNE18NModelTransformation` utility.

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
