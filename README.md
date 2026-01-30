
# CountLOC

A Bash script to count the Lines of Code (LOC) committed to a Git repository, grouped by month.

It loops through the years and months you specify, filters the `git log` by the current user, and calculates the gross additions.

### Features
* **Auto-detects Author:** Automatically uses your local `git config user.name`.
* **Gross Additions Only:** Counts only new lines written (always positive). Deletions are ignored.
* **Smart Date Handling:** Accurately calculates month boundaries to ensure no commits are missed.

### How to use it

1. **Save the file**
   Create a file named `countLoc.sh` and paste the script into it.

2. **Make it executable**
   Run this command in your terminal:
   ```bash
   chmod +x countLoc.sh
   ```

3. **Run it**
    Pass the start year and end year as arguments:
    ```bash
    ./countLoc.sh 2024 2026
    ```



### Output Example

```text
Counting LOC (Gross Additions) for author: kanshuYokoo
YYYY  MM    LOC
2024  1     3120
2024  2     71
2024  3     8898
2024  4     1667
...
2024  10    2470
2024  11    30969
2024  12    1723
```

### Important Notes

* **Additions Only:** This script counts **Gross Additions** (lines added). It intentionally ignores deleted lines. This means the result represents "Work Produced" and will **always be positive**.
* **Refactoring:** If you delete 10,000 lines and add 5 lines, this script will report `5` LOC, not `-9995`.
* **Author Name:** The script attempts to detect your name automatically using `git config user.name`. If it is not finding your commits, edit the `AUTHOR` variable inside the script manually.
