class Movie < ActiveRecord::Base
  def self.get_all(sorting)
    if sorting == 'title'
      return self.all()
    elsif sorting == 'date'
      return self.all()
    else
      return self.all()
    end
  end

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
