UT #1
Copied from Validation 1 reading for Basic Validations
https://github.com/appacademy/curriculum/blob/master/sql/readings/validations.md

Handy chart for constraints in database and the corresponding validations in the model. Including the way to pair 2 scopes for validation. Like the combination of Company and Bus route number which neither of them individually unique but both of them combined. 

### Database and Model layer validation reference

Validation    |  Database Constraint  |  Model Validation
-----------   |-----------------------|------------------
Present       |  null: false          |  presence: true
All Unique    |  add_index :tbl, :col, unique: true                   | uniqueness: true
Scoped Unique |  add_index :tbl, [:scoped_to_col, :col], unique: true | uniqueness: { scope: :scoped_to_col }
