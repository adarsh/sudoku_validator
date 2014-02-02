require 'set'

class Sudoku
  N = 3
  INDEX_N = N - 1
  SIZE = N*N

  MATRIX =
    [
      [ 3, 1, 6, 5, 7, 8, 4, 9, 2],
      [ 5, 2, 9, 1, 3, 4, 7, 6, 8],
      [ 4, 8, 7, 6, 2, 9, 5, 3, 1],
      [ 2, 6, 3, 4, 1, 5, 9, 8, 7],
      [ 9, 7, 4, 8, 6, 3, 1, 2, 5],
      [ 8, 5, 1, 7, 9, 2, 6, 4, 3],
      [ 1, 3, 8, 9, 4, 7, 2, 5, 6],
      [ 6, 9, 2, 3, 5, 1, 8, 7, 4],
      [ 7, 4, 5, 2, 8, 6, 3, 1, 9],
    ]

  def initialize
    @valid = true
  end

  def run
    # %w(rows columns submatrices).map { |element| validate_array(element) }
    validate_all_rows
    validate_all_columns
    validate_all_submatrices
    puts @valid
  end

  private

  def validate_all_rows
    rows.each do |row|
      validate_array(row)
    end
  end

  def validate_all_columns
    columns.each do |column|
      validate_array(column)
    end
  end

  def validate_all_submatrices
    submatrices.each do |submatrix|
      validate_array(submatrix)
    end
  end

  def rows
    MATRIX
  end

  def submatrices
    (0..INDEX_N).inject([]) do |column_collector, column_index|
      column_collector << (0..INDEX_N).inject([]) do |row_collector, row_index|
        row_range = (row_index * N)..(row_index * N + N - 1)
        column_range  = (column_index * N)..(column_index * N + N - 1)
        row_collector << sub_array(MATRIX, row_range, column_range)
      end
    end.flatten(1)
  end

  def sub_array(matrix, rows, columns)
    matrix[rows].map { |row| row[columns] }.flatten
  end

  def validate_array(array)
    if array.sort != available_digits.to_a
      @valid = false
    end
  end

  def columns
    rows.transpose
  end

  def available_digits
    1..SIZE
  end
end

Sudoku.new.run
