class SudokuValidator
  N = 3
  INDEX_N = N - 1
  SIZE = N * N

  def initialize(matrix)
    @matrix = matrix
    @valid = true
  end

  def validate
    elements_to_validate.map { |element| validate_arrays(element) }
    @valid
  end

  private

  def elements_to_validate
    [rows, columns, submatrices]
  end

  def rows
    @matrix
  end

  def columns
    rows.transpose
  end

  def submatrices
    (0..INDEX_N).inject([]) do |column_collector, column_index|
      column_collector <<
        (0..INDEX_N).inject([]) do |row_collector, row_index|
          row_collector << sub_array(row_index, column_index)
        end
    end.flatten(1)
  end

  def sub_array(row_index, column_index)
    row_range = (row_index * N)..(row_index * N + INDEX_N)
    column_range  = (column_index * N)..(column_index * N + INDEX_N)
    @matrix[row_range].map { |row| row[column_range] }.flatten
  end

  def validate_arrays(arrays)
    arrays.map { |array| validate_array(array) }
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
