from collections import Counter


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


# Функция для получения данных сотрудников и их отделов
def get_employees_and_departments(employees, departments):
    result = sorted(
        [(emp['last_name'], dept['name']) for emp in employees for dept in departments if emp['department_id'] == dept['id']],
        key=lambda x: x[0]
    )
    return result


# Функция для получения отделов с количеством сотрудников
def get_departments_with_employee_count(employees, departments):
    employee_counts = Counter([dept['id'] for emp in employees for dept in departments if emp['department_id'] == dept['id']])
    result = sorted(
        [(dept['name'], employee_counts.get(dept['id'], 0)) for dept in departments],
        key=lambda x: x[1], reverse=True
    )
    return result


# Функция для получения сотрудников с фамилией, оканчивающейся на "ов"
def get_employees_last_name_ov(employees, departments):
    ov_employees = [emp for emp in employees if emp['last_name'].endswith('ов')]
    result = [(emp['last_name'], dept['name'])
              for emp in ov_employees
              for dept in departments
              if emp['department_id'] == dept['id']]
    return result