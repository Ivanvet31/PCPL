class Column:
    def __init__(self, name, data_type):
        self.name = name
        self.data_type = data_type

class Table:
    def __init__(self, name, columns):
        self.name = name
        self.columns = columns

# Определение столбцов для таблиц Employee и Department
employee_columns = [
    Column('id', 'int'),
    Column('last_name', 'varchar'),
    Column('salary', 'float'),
    Column('department_id', 'int')
]

department_columns = [
    Column('id', 'int'),
    Column('name', 'varchar')
]

# Создание таблиц
employees_table = Table('Employee', employee_columns)
departments_table = Table('Department', department_columns)

# Определение столбцов для таблицы Employee_Department
employee_department_columns = [
    Column('employee_id', 'int'),
    Column('department_id', 'int')
]

# Создание таблицы
employee_departments_table = Table('Employee_Department', employee_department_columns)

# Данные для таблицы Employee
employees_data = [
    {'id': 1, 'last_name': 'Иванов', 'salary': 50000, 'department_id': 1},
    {'id': 2, 'last_name': 'Петров', 'salary': 60000, 'department_id': 2},
    {'id': 3, 'last_name': 'Сидоров', 'salary': 70000, 'department_id': 1}
]

# Данные для таблицы Department
departments_data = [
    {'id': 1, 'name': 'Продажи'},
    {'id': 2, 'name': 'Маркетинг'}
]

# Данные для таблицы Employee_Department
employee_departments_data = [
    {'employee_id': 1, 'department_id': 1}, # Иванов работает в Продажах
    {'employee_id': 2, 'department_id': 2}, # Петров работает в Маркетинге
    {'employee_id': 3, 'department_id': 1}  # Сидоров тоже работает в Продажах
]

# Заполняем таблицы данными
employees = []
for emp in employees_data:
    employees.append(emp)
    
departments = []
for dept in departments_data:
    departments.append(dept)
    
employee_departments = []
for ed in employee_departments_data:
    employee_departments.append(ed)

# Запросы

def get_employees_and_departments():
    result = sorted(
        [(emp['last_name'], dept['name']) for emp in employees for dept in departments if emp['department_id'] == dept['id']],
        key=lambda x: x[0]
    )
    return result

def get_departments_with_employee_count():
    from collections import Counter
    employee_counts = Counter([dept['id'] for emp in employees for dept in departments if emp['department_id'] == dept['id']])
    result = sorted(
        [(dept['name'], employee_counts.get(dept['id'], 0)) for dept in departments],
        key=lambda x: x[1], reverse=True
    )
    return result

def get_employees_last_name_ov():
    ov_employees = [emp for emp in employees if emp['last_name'].endswith('ов')]
    result = [(emp['last_name'], dept['name'])
              for emp in ov_employees
              for dept in departments
              if emp['department_id'] == dept['id']]
    return result

# Выполнение запросов
print("Запрос 1:", get_employees_and_departments())
print("Запрос 2:", get_departments_with_employee_count())
print("Запрос 3:", get_employees_last_name_ov())
