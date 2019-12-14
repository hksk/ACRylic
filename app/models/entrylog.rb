class Entrylog < ApplicationRecord
	serialize :content, JSON
end
