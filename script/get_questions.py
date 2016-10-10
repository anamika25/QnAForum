from bs4 import BeautifulSoup
import requests
import scrape_links
import time
import MySQLdb

try:
    #get topics
    f = open("topics.txt", 'r')
    topic_links = f.readlines()
    f.close()
    cnx = MySQLdb.connect('database2.cs.tamu.edu', 'itsvaibhavmittal', 'Vaibhav@123', 'itsvaibhavmittal-db-proj1')
    cursor = cnx.cursor()

    for topic_link in topic_links:
        print("Topic link: " + topic_link)
        page = requests.get(topic_link)
        html = BeautifulSoup(page.text, "html.parser")
        counter = 1

        for page_count in range(0, 3):
            print("Page number: " + str(counter))
            ques_boxes = html.findAll("div", {"class": "question-summary"})
            print("Questions: " + str(len(ques_boxes)))
            for ques_box in ques_boxes:
                ques_link = ques_box.find("a", {"class": "question-hyperlink"})
                print("http://stackoverflow.com" + ques_link['href'])
                scrape_links.scrape_qa("http://stackoverflow.com" + ques_link['href'], cursor)

            counter = counter + 1
            topic_link = topic_link + "&page=" + str(counter)
            
            page_content = requests.get(topic_link)
            html = BeautifulSoup(page_content.text, "html.parser")
            
    cnx.commit()
    cursor.close()
    cnx.close()

except Exception as e:
    print(e)
