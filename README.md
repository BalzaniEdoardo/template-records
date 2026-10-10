# Records

A shared table of records kept in git. `data/records.csv` holds the records, `data/schema.yaml` says which columns exist and which values are allowed, and git keeps the full history of every change.

This repository is a template. To start a dataset of your own, make a copy (on GitHub: *Use this template*), describe your columns in `data/schema.yaml`, and replace the example records.

## What is in this folder

| File | Contents |
|---|---|
| `data/records.csv` | the records, one per line, sorted by record number |
| `data/schema.yaml` | the columns and their rules; see [Describing the columns](#describing-the-columns) |
| `safedata.toml` | marks this folder as a dataset for the `safedata` tool, and says where the two files above are |
| `.gitattributes` | tells git to use the `safedata` add-ons for `records.csv` |
| `.github/workflows/validate.yml` | checks every push against the schema |
| `docs/EXCEL_SETUP.md` | connecting an Excel workbook for analysis |

## Setting up a computer

Install [git](https://git-scm.com) and [uv](https://docs.astral.sh/uv/), then the `safedata` tool (once per computer):

```sh
uv tool install git+https://github.com/BalzaniEdoardo/safedata
```

Then get a copy of the dataset and set up the git add-ons for it (once per copy):

```sh
git clone <address of this repository> records
cd records
safedata install
```

`safedata install` configures git in this copy to sort `records.csv` when it is staged, merge it record by record, and check it against the schema before each commit. `safedata edit` runs it automatically, so forgetting it is harmless.

## Editing records

All `safedata` commands work on the dataset folder you are in, like git commands.

1. Get the latest version: `git pull`, or the pull/sync button of your git client.
2. In the dataset folder, run `safedata edit`. A tab opens in your browser. Keep the terminal window open while you edit.
3. Change values in the table, add records with *Add record*, or mark records with *Delete*. Changed cells are highlighted, and cells with a problem are outlined in red; hover over them to see why.
4. Click **Save**. This checks the edits against the schema and writes `data/records.csv`. It does nothing else.
5. Record the change in git with any git client, or on the command line:

```sh
git diff --word-diff data/records.csv     # review: changed cells are marked
git commit -m "Add March samples" data/records.csv
git push
```

The commit is refused if `records.csv` does not match the schema, with a list of the problems.

## Viewing the history

```sh
git log -p --word-diff data/records.csv     # every change, cell by cell
git log -L '/^42,/,+1:data/records.csv'     # the history of record 42
git blame data/records.csv                  # the last commit that changed each record
```

Graphical git clients show the same history in their file-history views.

## When a pull reports a conflict

If two people changed the same value of the same record, `git pull` stops and prints which records are affected and what to do. In `records.csv`, each of those records appears twice between git's conflict markers:

```
<<<<<<< local
12,2020-01-01,North,survey,Maria,7,true,
=======
12,2020-01-01,North,survey,Maria,8,true,
>>>>>>> incoming
```

1. Keep one version of each record: in your git client's conflict view, in a text editor (keep one line and delete the three marker lines), or with `safedata edit`, which shows both versions side by side.
2. Review the result and stage it: `git add data/records.csv`
3. Finish the merge: `git commit`

To give up and return to the state before the pull: `git merge --abort`.

Changes to different records, or to different columns of the same record, never conflict: git combines them on its own.

## Describing the columns

`data/schema.yaml` lists the columns in the order they appear in `records.csv`. An excerpt from the example:

```yaml
key: id

columns:
  - name: id
    type: int
    required: true
    unique: true

  - name: site
    type: choice
    required: true
    choices: [North, South, East, West]

  - name: value
    type: float
    min: 0
    description: Measured value, if any.
```

`key` names the column that identifies each record. It must be a column of type `int`, so that new records can be numbered automatically. Mark it `required` and `unique`.

Each column can have these settings:

| Setting | For types | Meaning |
|---|---|---|
| `name` | all | column name, exactly as in the first line of `records.csv` |
| `type` | all | one of the types below; `string` if omitted |
| `required` | all | `true`: the value cannot be empty |
| `unique` | all | `true`: no two records can have the same value |
| `choices` | `choice` | the allowed values; the editor shows them as a dropdown |
| `min`, `max` | `int`, `float`, `date` | lowest and highest allowed value, both included |
| `description` | all | shown when hovering over the column title in the editor |

| Type | Values | Written in the file as |
|---|---|---|
| `int` | whole numbers | `42` |
| `float` | numbers | `3.5` |
| `date` | dates | `2024-03-15` |
| `bool` | yes/no | `true` or `false` |
| `choice` | one of `choices` | the choice, spelled as in the schema |
| `string` | any text on one line | the text |

The editor builds its inputs from the schema and checks every value against it, so changing the schema needs no change to the tool.

### Adding a column

1. Add the column to `data/schema.yaml`, at the end of the list.
2. Add its name at the end of the first line of `data/records.csv`, after a comma. Existing records get an empty value in the new column.
3. If the column is `required`, fill it in for every record with `safedata edit` before committing.
4. Commit both files together.

Add the name at the end of the first line only: inserting it in the middle would shift the existing values into the wrong columns.

### Renaming a column

Change the name in `data/schema.yaml` and in the first line of `data/records.csv`, and commit both files together.

### Changing a column's rules

Edit its settings in `data/schema.yaml`. If existing records no longer pass the new rules, `safedata validate` lists them; fix them with `safedata edit` and commit the schema and the records together.

### Removing a column

Removing a column means deleting one value from every line of `records.csv`, which is error-prone by hand. Ask whoever maintains the dataset to do it.

After any change to the columns, people who analyse the records in Excel need to update their query: see [docs/EXCEL_SETUP.md](docs/EXCEL_SETUP.md).

## Analysing the records in Excel

An Excel workbook can load `records.csv` as a read-only table with Power Query and reload it with *Data > Refresh All*, keeping its filters and sort order. [docs/EXCEL_SETUP.md](docs/EXCEL_SETUP.md) describes the setup.
