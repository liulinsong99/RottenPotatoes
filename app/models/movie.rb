class Movie < ActiveRecord::Base
  def self.with_ratings(ratings_list, sorting)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # if ratings_list is nil, retrieve ALL movies
    if ratings_list == nil or ratings_list == []
      records = self.all()
    else
      records = self.where(rating: ratings_list)
    end

    if sorting == 'title'
      return records.order(:title)
    elsif sorting == 'date'
      return records.order(:release_date)
    else
      return records
    end
  end
end
