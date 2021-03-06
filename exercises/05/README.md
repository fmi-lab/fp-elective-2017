Упражнение 5
============

Задачи
------

1. Да се дефинира функция `maximum(l)`, която
намира най-голямото число в списъка от числа `l`.

2. Да се дефинира функция `remove(l, x)`, която връща нов списък,
в който е премахнато първото срещане на елемента `x` в списъка `l`.

   Например, `(remove '(1 7 3 3 7) 7)` връща `'(1 3 3 7)`.

3. Да се дефинира функция `selection-sort(l)`, която връща списъка `l` сортиран
във възходящ ред чрез метода на пряката селекция. Добавете втори аргумент
`comp`, който е бинарен оператор, който определя реда на сортировката.

   Например, `(selection-sort '(1 2 3 4 5 6 7) >)` връща `'(7 6 5 4 3 2 1)`.

4. Да се дефинира функция `partition(p, l)`, която връща списък от два
подсписъка, където:

   - първият съдържа всички елементи на `l`, които удовлетворяват предиката `p`.
   - вторият съдържа всички останали елементи на `l`.

   Например, `(partition even? '(1 2 3 4 5 6 7))` връща `'((2 4 6) (1 3 5 7))`.

5. Да се дефинира функция `flatten(l)`, която приема списък от _атоми_ (числа)
и _списъци с атоми_ `l` и връща списък с всички атоми.

   Например, `(flatten '((1 2) 3 (4 5) (6 7)))` връща `'(1 2 3 4 5 6 7)`.

6. Да се дефинира функция `map-deep(f, l)`, която прилага функцията `f`
върху всеки атом от всеки вложен списък в списъка `l`.

   Например, `(map-deep square '((1 2 (3 4)) 5))` връща `'((1 4 (9 16)) 25)`.

7. Да се дефинира функция `zip(a, b)`, която чифтосва списъците `a` и `b`
поелементно и връща списък от наредени двойки (a<sub>i</sub>, b<sub>i</sub>),
където a<sub>i</sub> и b<sub>i</sub> са съответно i-тите елементи в `a` и `b`.
Новият списък е с дължината на по-малкия от двата подадени списъка.

   Например, `(zip '(1 3 5) '(2 4 6 8))` връща `'((1 2) (3 4) (5 6))`.

8. Да се дефинира функция `remove-duplicates(l)`, която премахва всички
дубликати в списъка `l` и остава само уникалните елементи. Редът е без значение.

   Например, `(remove-duplicates '(4 3 3 2 5 2))` връща `'(4 3 2 5)`.

9. Да се дефинира функция `chunk(l, n)`, която разбива списъка `l` на
подсписъци с дължина `n`.
Последният подсписък може да е с дължина по-малка от n, ако дължината на `l`
не е кратна на `n`.

   Например, `(chunk '(1 1 1 2 2 2 3 4) 3)` връща `'((1 1 1) (2 2 2) (3 4))`.
