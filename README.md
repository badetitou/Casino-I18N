# Casino-I18N

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
