import pytest
from rk1_refactored import (
    get_employees_and_departments,
    get_departments_with_employee_count,
    get_employees_last_name_ov
)


@pytest.fixture
def employees():
    return [
        {'id': 1, 'last_name': 'Иванов', 'salary': 50000, 'department_id': 1},
        {'id': 2, 'last_name': 'Петров', 'salary': 60000, 'department_id': 2},
        {'id': 3, 'last_name': 'Сидоров', 'salary': 70000, 'department_id': 1}
    ]


@pytest.fixture
def departments():
    return [
        {'id': 1, 'name': 'Продажи'},
        {'id': 2, 'name': 'Маркетинг'}
    ]


def test_get_employees_and_departments(employees, departments):
    expected_result = [
        ('Иванов', 'Продажи'),
        ('Петров', 'Маркетинг'),
        ('Сидоров', 'Продажи')
    ]
    assert get_employees_and_departments(employees, departments) == expected_result


def test_get_departments_with_employee_count(employees, departments):
    expected_result = [
        ('Продажи', 2),
        ('Маркетинг', 1)
    ]
    assert get_departments_with_employee_count(employees, departments) == expected_result


def test_get_employees_last_name_ov(employees, departments):
    expected_result = [
        ('Иванов', 'Продажи'),
        ('Петров', 'Маркетинг'),
        ('Сидоров', 'Продажи')
    ]
    assert get_employees_last_name_ov(employees, departments) == expected_result