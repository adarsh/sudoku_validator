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
    rows.map { |row| validate_array(row) }
    columns.map { |column| validate_array(column) }
    submatrices.map { |submatrix| validate_array(submatrix) }
    puts @valid
  end

  private

  def rows
    MATRIX
  end

  def columns
    rows.transpose
  end

  def submatrices
    (0..INDEX_N).inject([]) do |column_collector, column_index|
      column_collector <<
        (0..INDEX_N).inject([]) do |row_collector, row_index|
          row_range = (row_index * N)..(row_index * N + INDEX_N)
          column_range  = (column_index * N)..(column_index * N + INDEX_N)
          row_collector << sub_array(MATRIX, row_range, column_range)
        end
    end.flatten(1)
  end

  def sub_array(matrix, row_range, column_range)
    matrix[row_range].map { |row| row[column_range] }.flatten
  end

  def validate_array(array)
    if array.sort != available_digits
      @valid = false
    end
  end

  def available_digits
    (1..SIZE).to_a
  end
end

Sudoku.new.run
