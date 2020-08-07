#!/usr/bin/env python

import os
import sys

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


if sys.argv[-1] == 'publish':
    os.system('python setup.py sdist upload')
    sys.exit()

readme = open('README.rst').read()
doclink = """
Documentation
-------------

The full documentation is at http://aobadiscordbot.rtfd.org."""
history = open('HISTORY.rst').read().replace('.. :changelog:', '')

setup(
    name='aobadiscordbot',
    version='0.0.1',
    description='Aoba Discord Bot',
    long_description=readme + '\n\n' + doclink + '\n\n' + history,
    author='Douglas Carvalho',
    author_email='douglasc.dev@gmail.com',
    url='https://github.com/Aoba-Team/aobadiscordbot',
    packages=[
        'aobadiscordbot',
    ],
    package_dir={'aobadiscordbot': 'aobadiscordbot'},
    include_package_data=True,
    install_requires=[
    ],
    license='MIT',
    zip_safe=False,
    keywords='aobadiscordbot',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: Implementation :: PyPy',
    ],
)
