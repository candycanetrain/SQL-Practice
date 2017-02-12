# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

# BONUS PROBLEM: requires sub-queries or joins. Attempt this after completing
# sections 04 and 07.

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
  select distinct yr
  from nobels
  where nobels.subject = 'Physics'
    and yr NOT IN (
      select yr
      from nobels
      where subject = 'Chemistry'
    );
  SQL
end
