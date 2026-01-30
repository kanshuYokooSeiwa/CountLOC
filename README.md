# CountLOC
bash script to count the line of codes commited to githab 

It loops through the years and months you specify, applies the `git log` logic from your solution, and formats the output exactly as requested (`YYYY MM LOC`).

### How to use it

1. **Save the file**: Create a file named `count_loc.sh` and paste the code above into it.
2. **Make it executable**: Run this command in your terminal:
```bash
chmod +x count_loc.sh
```


3. **Run it**: Pass the start year and end year as arguments.
```bash
./count_loc.sh 2024 2025
```



### Output Example

```text
Counting LOC (Net Delta) for author: Your Name
-------------------------------------------
YYYY MM   LOC
2024 01   150
2024 02   2300
2024 03   -50
...
```

### Important Notes

* **The "31st" Logic:** As you noted, setting `until="$year-$month-31"` works perfectly in Git commands. Git interprets dates loosely and will capture up to the end of the month even if the month only has 28 or 30 days.
* **Net vs. Added:** The script currently outputs the **Net Delta** (`Added - Removed`), which is what the `loc` variable represented in your original solution.
* If you see a **negative number**, it means you deleted more lines than you added that month (refactoring).
* If you *only* want to see lines added (ignoring deletions), change `END { print loc }` to `END { print add }` inside the script.