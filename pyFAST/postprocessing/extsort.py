#!/usr/bin/env python

#
# Sort large text files in a minimum amount of memory
#
import os
import sys
import operator

class FileSplitter(object):

    def __init__(self, filename):
        self.filename = filename
        self.BLOCK_FILENAME_FORMAT = '%s_{0}.dat' % filename
        self.block_filenames = []

    def write_block(self, data, block_number):
        filename = self.BLOCK_FILENAME_FORMAT.format(block_number)
        file = open(filename, 'w')
        file.write(data)
        file.close()
        self.block_filenames.append(filename)

    def get_block_filenames(self):
        return self.block_filenames

    def split(self, block_size, sort_key=None):
        file = open(self.filename, 'r')
        i = 0

        while True:
            lines = file.readlines(block_size)

            if lines == []:
                break

            if sort_key is None:
                lines.sort()
            else:
                lines.sort(key=sort_key)

            self.write_block(''.join(lines), i)
            i += 1

    def cleanup(self):
        map(lambda f: os.remove(f), self.block_filenames)

class MergeByKey(object):
    def _line_smaller(self, line1, line2):
        nums1 = line1.split()
        nums2 = line2.split()
        x1 = int(nums1[0])
        y1 = int(nums1[1])
        x2 = int(nums2[0])
        y2 = int(nums2[1])
        return (x1 < x2) or ((x1 == x2) and (y1 <= y2))

    def select(self, choices):
        min_index = choices.keys()[0]
        for i in choices.keys()[1:]:
            if self._line_smaller(choices[i], choices[min_index]):
                min_index = i
        return min_index

class FilesArray(object):
    def __init__(self, files):
        self.files = files
        self.empty = set()
        self.num_buffers = len(files)
        self.buffers = {i: None for i in range(self.num_buffers)}

    def get_dict(self):
        return {i: self.buffers[i] for i in range(self.num_buffers) if i not in self.empty}

    def refresh(self):
        for i in range(self.num_buffers):
            if self.buffers[i] is None and i not in self.empty:
                self.buffers[i] = self.files[i].readline()

                if self.buffers[i] == '':
                    self.empty.add(i)

        if len(self.empty) == self.num_buffers:
            return False

        return True

    def unshift(self, index):
        value = self.buffers[index]
        self.buffers[index] = None

        return value


class FileMerger(object):
    def __init__(self, merge_strategy):
        self.merge_strategy = merge_strategy

    def merge(self, filenames, outfilename, buffer_size):
        outfile = open(outfilename, 'w', buffer_size)
        buffers = FilesArray(self.get_file_handles(filenames, buffer_size))

        while buffers.refresh():
            min_index = self.merge_strategy.select(buffers.get_dict())
            outfile.write(buffers.unshift(min_index))

    def get_file_handles(self, filenames, buffer_size):
        files = {}

        for i in range(len(filenames)):
            files[i] = open(filenames[i], 'r', buffer_size)

        return files



class ExternalSort(object):
    def __init__(self, block_size):
        self.block_size = block_size

    def sort(self, filename, sort_key=None):
        num_blocks = self.get_number_blocks(filename, self.block_size)
        splitter = FileSplitter(filename)
        splitter.split(self.block_size, sort_key)

        merger = FileMerger(MergeByKey())
        buffer_size = self.block_size / (num_blocks + 1)
        merger.merge(splitter.get_block_filenames(), filename + "_sorted", buffer_size)

        splitter.cleanup()

    def get_number_blocks(self, filename, block_size):
        return (os.stat(filename).st_size / block_size) + 1


def parse_memory(string):
    if string[-1].lower() == 'k':
        return int(string[:-1]) * 1024
    elif string[-1].lower() == 'm':
        return int(string[:-1]) * 1024 * 1024
    elif string[-1].lower() == 'g':
        return int(string[:-1]) * 1024 * 1024 * 1024
    else:
        return int(string)


