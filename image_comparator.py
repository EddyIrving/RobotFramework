from PIL import Image, ImageChops
import os
import requests


def download_image(url, save_path):
    """
    Faz o download de uma imagem e salva no caminho especificado.
    """
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(save_path, 'wb') as file:
            for chunk in response.iter_content(1024):
                file.write(chunk)
        return True
    return False


class ImageComparator1:
    pass

    # def compare_images(image1_path, image2_path, threshold=5):
    #     """
    #     Compara duas imagens pixel a pixel.
    #     Retorna True se forem semelhantes e False se forem diferentes.
    #     """
    #     if not os.path.exists(image1_path) or not os.path.exists(image2_path):
    #         raise FileNotFoundError("Uma das imagens não foi encontrada!")
    #
    #     img1 = Image.open(image1_path).convert("RGB")
    #     img2 = Image.open(image2_path).convert("RGB")
    #
    #     diff = ImageChops.difference(img1, img2)
    #     diff_value = sum(diff.getdata()) / (img1.width * img1.height * 3)
    #
    #     return diff_value < threshold
    #
    #
    # class ImageComparator:
    """ Biblioteca customizada para comparar imagens no Robot Framework """


def compare_images(image1_path, image2_path, threshold=5):
    """
    Compara duas imagens pixel a pixel.
    Retorna True se forem semelhantes e False se forem diferentes.
    """
    if not os.path.exists(image1_path) or not os.path.exists(image2_path):
        raise FileNotFoundError("Uma das imagens não foi encontrada!")

    img1 = Image.open(image1_path).convert("RGB")
    img2 = Image.open(image2_path).convert("RGB")

    diff = ImageChops.difference(img1, img2)
    diff_data = list(diff.getdata())  # Converte os dados da diferença para uma lista de tuplas (R, G, B)

    # Calcula a média da diferença dos canais R, G e B
    diff_value = sum(sum(pixel) for pixel in diff_data) / (img1.width * img1.height * 3)

    return diff_value < threshold


class ImageComparator:
    pass  # Aqui você pode implementar métodos para comparação de imagens se necessário.
