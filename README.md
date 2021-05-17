
# Online Experiments

This is supposed to be an internal documentation and collection of useful code snippets for `labJS` and `JATOS`.  

## labJS


- **Add data transmission points in your study:** JATOS only saves data after a component is finished. To incrementaly save data you can use the `Data Transmission` template from labJS at certain points in your study.

## JATOS

See [here](https://www.jatos.org/Restricting-study-flow.html#ensure-a-linear-study-flow-since-version-351) for more information: 


Some "best" practice procedure I used so far:

- **Define different batches for testing and your actual study:** You can define different batches with different types of links (single general for the actual study and multiple general for testing)

-  **Single-use worker link to prevent workers running the study twice:** To prevent a participant from running the same study twice use the single-use workers: General Single worker (or Personal Single worker and the MTurk worker)

-  **Do not allow reload or prevent a reload of the same component:**  A worker can press their browser’s reload button and by  default JATOS will respond with the same component again: by default, the worker can do a component multiple times. To prevent this each component properties has a checkbox Allow reload.


What do you might to think of if you have more than one component in your online study:

 - **Ensure a linear study flow:** A worker can press their browsers back button and by default JATOS will  response with the previous component, the one that was done before by the worker.  This might allow a worker to divert from the intended study flow.  To prevent this each study properties has a checkbox Linear study flow.

Or if you are using prolific:

   
- **Preview Links**: Perhaps you want to allow General Single or Personal Single workers to have a peek into the study, to preview it.








