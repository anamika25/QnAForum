import requests
import time
import os
import sys
import scrape
import io
from bs4 import BeautifulSoup
import MySQLdb
from random import randint

def scrape_qa(baseUrl, cursor):
    try:
      page = requests.get(baseUrl)
      html = BeautifulSoup(page.text, "html.parser")

      #Question
      questionTitle = html.find("div",{"id":"question-header"}).find("a", {"class":"question-hyperlink"}).text
      questionTitle = questionTitle.replace("'", '"')
      questionTag = html.find("div",{"class":"question"})
      question = questionTag.find("div",{"class":"post-text"})
      questionText = u''.join(question.findAll(text=True)).replace("'", '"')
      questionText = u''.join([i if ord(i) < 256 else ' ' for i in questionText])
      
      #Random user
      userId = randint(1,10)
      
      cursor.execute("INSERT into Questions (title, text, user_id) values ('%s', '%s', %s)" %(questionTitle, questionText, userId))
      questionId = cursor.lastrowid
      print("Question inserted")
      
      #Tags/Category
      tags = questionTag.find("div",{"class":"post-taglist"}).findAll("a")
      for tag in tags:
        query = "SELECT category_id from Category where name='%s'" %(tag.text)
        cursor.execute(query)
        data = cursor.fetchone()
        if data is not None:
          categoryId = data[0]
          cursor.execute("INSERT into Question_Category_mapping (question_id, category_id) values (%s, %s)" %(questionId, categoryId))
        else:
          cursor.execute("INSERT into Category (name) values ('%s')" %(tag.text))
          categoryId = cursor.lastrowid
          cursor.execute("INSERT into Question_Category_mapping (question_id, category_id) values (%s, %s)" %(questionId, categoryId))
      print("Tags inserted")
                
      #Answer
      answerList = html.find("div",{"id":"answers"}).findAll("div",{"class":"answer"})
      for answerTag in answerList:
        answer = answerTag.find("td",{"class":"answercell"}).find("div",{"class":"post-text"})
        answerText = u''.join(answer.findAll(text=True)).replace("'", '"')
        answerText = u''.join([i if ord(i) < 256 else ' ' for i in answerText])
        userId = randint(1,10)
        cursor.execute("INSERT into Answers (question_id, user_id, text) values (%s, %s, '%s')" %(questionId, userId, answerText))
      print("Answers inserted")
                
    except Exception as e:
        print("Exception Caught:",e)
        return

# cnx = MySQLdb.connect('database2.cs.tamu.edu', 'itsvaibhavmittal', 'Vaibhav@123', 'itsvaibhavmittal-db-proj1')
# cursor = cnx.cursor()
# scrape_qa('http://stackoverflow.com/questions/11227809/why-is-it-faster-to-process-a-sorted-array-than-an-unsorted-array', cursor)
# cnx.commit()
# cursor.close()
# cnx.close()