# **elm-codebase**

**elm-codebase** is a metaprogramming tool that makes your Elm development more efficient and reliable by giving you the ability to:

- **Find mistakes** and enforce good practices.
- **Automate your fixes** with confidence and simplicity while ensuring that everything still compiles.
- **Generate boilerplate code** that depends not only on your existing Elm code but on any of your project's files like SVGs, CSVs, HTML, CSS, Markdown, JSON, images, and more.
- **Insert new code** wherever you want, within your existing modules or in new ones while keeping responsibility clear.
- **Extract valuable insights** from your project to help you understand how it’s structured and where you might improve it.

This creates a whole new dimension for you to think about and work on your codebase.

## **Introduction**

### **What is it?**

It is both a CLI program and an Elm package:

- **A CLI Program** that reads, parses, and monitors your code for changes, applying rules across your codebase. It is built into **elm-platforms** and it integrates as a platform capability.
- **An Elm Package** that is the interface for you to define rules on how your code should be generated, analyzed, or transformed.

### **How does it compare to other tools?**

**elm-codebase** was inspired by the great work done by **Jeroen Engels** and **Matthew Griffith** on [**elm-review**](https://github.com/jfmengels/elm-review) and [**elm-codegen**](https://github.com/mdgriffith/elm-codegen/tree/4.2.2) respectively.

- **elm-codebase** share the principle of **elm-review** of traversing, analyzing and applying fixes to the codebase but makes the generation of fixes much easier and reliable.
- **elm-codebase** shares automatic imports and built in type inference features with **elm-codegen** but it adds the ability to insert code inside of existing modules.

The main benefit of **elm-codegen** is that it uses the same data types both for going through existing code and for generating new one. This makes the metaprogramming code simpler and more flexible.

Also since it is built as a **elm-platforms** platform capability it is easy to build your own program or application with it.

### **Who is it for?**

**elm-codebase** is designed for anyone working with Elm:

- **Elm developers** who want to automate repetitive tasks and focus on building great features.
- **Tool builders** who need advanced metaprogramming capabilities to extend Elm’s functionality.
- **Team leads** who want to ensure their team’s code is consistent, high-quality, and easy to maintain.

Whether you’re working on a small project or a large one, **elm-codebase** can help you manage and evolve your Elm projects more efficiently and with fewer headaches.

## **Requirements**

### 1. **Rule Definition**

- **1.1**: **elm-codebase** visits every module, declaration, type from type declarations, expression from value declarations and non elm files from rule specified directories and formats. On every visited element it will run the rules that apply.
- **1.2**: Non elm file's content when visited will be provided as `String` to the rule where as parts of the codebase will be provided as **elm-codebase** AST types.
- **1.3**: Rules have the ability to throw errors on the visited elements and provide eventual automated fixes which can include modifications to user code and the generation of new declarations.
- **1.4**: Rules also make it possible to gather data about the codebase through a variable `data` type which will be passed through every visited element.
- **1.5**: They are two kinds of fixes: Single step ones that need to make a modification as they encounter a specific case and two step ones that will trigger a codebase wide modification based on a data point it finds in the codebase. An example of a single step fix would be for a rule that detects `.json` files in a specific folder and from this single information can generate the corresponding decoders. An example of a two step fix would be for a rule that first detects declarations with a `-- rename to <the_new_val_name>` and then needs to go through the whole codebase a second time to find and modify every place it finds that value being used in order to change its name.
- **1.6**: Rules that visit expressions and value declaration must indicate which type those should match. From this information **elm-codebase** is able to ensure the type safety of the code it generates and refactor at cli compile time.

#### 2. **Code Insertion and Ordering**

- **2.1**: Users recognize generated definitions thanks to the line comment placed right above it containing a rule tag. The tag is formatted as `@<rule-author>/<rule-pkg-name>:<trigger>` indicating which rule is responsible for generating the given declaration as well as the file, module or declaration that triggered the rule to generate it.
- **2.2**: Rule authors can explicitly ask for no tag to be put in front of some of their generated declarations. This is needed in cases where the fix also removes what triggered the generation as **elm-codegen** cleans the generated code before rerunning the rules.
- **2.3**: Users can modify the generated code by adding the "silent" keyword before the rule tag, taking control of the declaration and preventing future overwrites by **elm-codebase**.
- **2.4**: Generated code declarations are always inserted at the bottom of the module, ordered alphabetically by tag then declaration name if they have identical tags.
- **2.5**: If a declaration get generated in a module that does not yet exist, **elm-codebase** creates a new one in the `codebase/codegen` folder. This module will be removed if empty. If users want to write their own code in this module, they can move it to their `src/` directory.

#### 3. **Changes Traceability**

- **3.1**: Users can review code changes one by one or set a flag to automatically accept fixes from a given set of rules.
- **3.2**: Using a specific flag, **elm-codegen** can commit changes done by each rule one after the other. This allows users to review changes through diffs and manage the modifications post-generation if they prefer that workflow.

#### 4. **Error Reporting**

- **4.1**: Errors are reported directly in the terminal as they occur, unless an automatic fix is applied. These errors must meet the readability, friendliness, and actionability standards set by the Elm compiler.
- **4.2**: The **elm-codebase** documentation will guide rule authors to write high-quality error messages that adhere to these standards. The **elm-codebase** package will provide features that make this task as simple as possible for authors.
- **4.3**: **elm-codebase** does not support warnings that can be ignored by the user. All detected issues are treated as errors that require either an automated fix or manual action.

#### 5. **Guarantees**

- **5.1**: **elm-codebase** cleans unused imports, and adds the missing ones when it finds them in the project's scope. The module aliases and exposes are left untouched unless the whole import is not used.
- **5.2**: **elm-codebase** won't generate code using modules that are out of project scope. The cli will throw an error if the user tries to run a rule that requires some dependencies that aren't found in the project installed packages.
- **5.3**: **elm-codebase** ensures that the generated code always stays synchronized with the data that triggered its generation. To do this it will need to figure out what source (a file, a module or a declaration) triggered the generation of any given declarations so that it can remove it the next time this rule goes through the same source. The source might have changed and may or may not trigger that same generation the next time around.
- **5.4**: **elm-codebase** enforces a standardized formatting for the entire codebase. A rigid version of the **elm-format** is available but users can also define their own custom formatting function which turns **elm-codebase**'s AST back into Elm code.
- **5.5**: **elm-codebase** will manage conflicts between rule fixes the best it can by rerunning the rules on top of other's fixes until no more show up. However, if two or more rules battle to modify the same piece of code in different ways or generate conflicting definitions **elm-codebase** will throw an error, and it will be up to the user to ensure their rules are compatible.

#### 6. **Efficiency and Scalability**

- **6.1**: **elm-codebase** watches the codebase for changes, ensuring that only modified files are reloaded instead of the entire codebase. For changes made to rules themselves, the CLI must recompile, but this process can be streamlined by enabling a flag that caches the state for a quick reload.
- **6.2**: Changes to the rest of the codebase (non-rule files) will not trigger a recompile of the CLI. This ensures that normal development work is not interrupted by unnecessary recompilations.
- **6.3**: **elm-codebase** operates on a single Elm project at a time. Users needing to run it on multiple projects must launch separate instances.
- **6.4**: As the codebase grows, **elm-codebase** may slow down due to increased code parsing and traversal. Users can mitigate this by optimizing rule efficiency or restructuring their project to reduce the scope of each **elm-codebase** run.

#### 7. **Integration and Compatibility**

- **7.1**: **elm-codebase** can handle any Elm package.
- **7.2**: **elm-codebase** can function in parallel to **elm-review**, **elm-codegen** and **elm-format**.
- **7.3**: **elm-codebase** works as an **elm-platforms** platform capability which means that it can be integrated into any larger apps running on platforms having the file system capability (e.g., Deno, Node and Tauri).
