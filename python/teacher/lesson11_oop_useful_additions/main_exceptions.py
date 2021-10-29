"""
beautiful soap,
aiogram
asyncio
requests
opencv (cv2) Pillow (PIL)
pandas
numpy

docker, git

учиться писать код вне ide
"""

class FloorsException(Exception):
    def __init__(self, floors):
        text = f'{floors} nor enough for parking'
        super().__init__(text)


if __name__ == '__main__':
    if 5 > 0:
        raise FloorsException(12)