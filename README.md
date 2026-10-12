# Records

A table of records kept in a git repository: `data/records.csv` holds the records, `data/schema.yaml` describes the columns and the values each one accepts, and git keeps the history of every change. The records are edited with [safedata](https://github.com/BalzaniEdoardo/safedata), which checks every change against the schema.

This repository is a template. To start a dataset of your own, click *Use this template* on GitHub, describe your columns in `data/schema.yaml`, and replace the example records.

The [safedata documentation](https://balzaniedoardo.github.io/safedata/) explains the workflow and how to use it.

## What is in this folder

| File | Contents |
|---|---|
| `data/records.csv` | the records, one per line |
| `data/schema.yaml` | the columns and the values they accept; see [How the records are stored and checked](https://balzaniedoardo.github.io/safedata/records/) |
| `safedata.toml` | marks this folder as a dataset for safedata, and says where the two files above are |
| `.gitattributes` | tells git to use safedata's checks for `records.csv` |
| `.github/workflows/validate.yml` | checks every change pushed to GitHub against the schema, and tests the setup steps below |
| `check-setup.sh`, `check-setup.ps1` | check that this computer and this copy are set up |

## Getting started

1. Install safedata, once per computer: see [Installing the safedata tool](https://balzaniedoardo.github.io/safedata/setup/#installing-the-safedata-tool).
2. Get a copy of this repository and set it up, once per copy:

    ```sh
    git clone <address of this repository> records
    cd records
    safedata install
    ```

3. Check the setup, in the dataset folder:

    - macOS and Linux: `./check-setup.sh`
    - Windows (PowerShell): `powershell -ExecutionPolicy Bypass -File .\check-setup.ps1`

Then edit the records with `safedata edit`, and record your changes with git.

## Documentation

- [Keeping a table of records safe](https://balzaniedoardo.github.io/safedata/): the workflow and its reasons
- [Setting up a computer and a copy of the dataset](https://balzaniedoardo.github.io/safedata/setup/)
- [How the records are stored and checked](https://balzaniedoardo.github.io/safedata/records/): the table, the id column, the schema
- [Editing records with safedata edit](https://balzaniedoardo.github.io/safedata/editing/)
- [Recording and reviewing changes with git](https://balzaniedoardo.github.io/safedata/git/)
- [Analysing the records in Excel](https://balzaniedoardo.github.io/safedata/excel/)
